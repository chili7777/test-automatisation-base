import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

public class TestRunner {

    @Test
    void testParallel() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");
        String dateTime = dateFormat.format(new Date());
        String reportDir = "build/karate-reports_" + dateTime;

        Results results = Runner.path("classpath:get-characters.feature",
                                     "classpath:get-character-by-id.feature",
                                     "classpath:create-character.feature",
                                     "classpath:update-character.feature",
                                     "classpath:delete-character.feature")
                              .outputCucumberJson(true)
                              .reportDir(reportDir)
                              .parallel(1);

        generateReport(results.getReportDir());

        assert results.getFailCount() == 0 : "There are test failures";
    }

    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(
                new File(karateOutputPath), new String[]{"json"}, true);

        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));

        File reportDir = new File(karateOutputPath);

        Configuration config = new Configuration(reportDir, "Marvel Characters API Tests");
        config.addClassifications("Environment", "Test");
        config.addClassifications("User", "hberrezu");

        File standardReportDir = new File("build/karate-reports");
        if (!standardReportDir.exists()) {
            standardReportDir.mkdirs();
        }

        try {
            FileUtils.copyDirectory(reportDir, standardReportDir);
        } catch (Exception e) {
            System.err.println("Error copying reports: " + e.getMessage());
        }

        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}