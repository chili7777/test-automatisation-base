import com.intuit.karate.junit5.Karate;

class KarateBasicTest {
    static {
        System.setProperty("karate.ssl", "true");
    }

    @Karate.Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());
    }

    @Karate.Test
    Karate testGetCharacters() {
        return Karate.run("classpath:get-characters.feature");
    }

    @Karate.Test
    Karate testGetCharacterById() {
        return Karate.run("classpath:get-character-by-id.feature");
    }

    @Karate.Test
    Karate testCreateCharacter() {
        return Karate.run("classpath:create-character.feature");
    }

    @Karate.Test
    Karate testUpdateCharacter() {
        return Karate.run("classpath:update-character.feature");
    }

    @Karate.Test
    Karate testDeleteCharacter() {
        return Karate.run("classpath:delete-character.feature");
    }
}