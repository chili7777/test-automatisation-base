import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

class KarateBasicTest {
    static {
        System.setProperty("karate.ssl", "true");
    }

    @Test
    void testAll() {
        Results results = Runner.path("src/test/java/com/pichincha/features")
                              .configDir("src/test/java")
                              .parallel(1);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}