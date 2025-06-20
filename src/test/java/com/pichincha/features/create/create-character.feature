@REQ_H01 @HU01 @marvel_characters_api @marvel_api @Agente2 @E2 @iniciativa_marvel @crearPersonaje
Feature: H01 API REST de personajes de Marvel - Crear personaje

  Background:
    * configure ssl = true
    * url port_marvel_api
    * def username = 'hberrezu'
    * def basePath = '/' + username + '/api/characters'
    * copy localUtils = call setLocalUtils()
    * def schemaOk = localUtils.schemaOk
    * def schemaError = localUtils.schemaError
    * def generateRandomCharacter = localUtils.generateRandomCharacter
    * def generateInvalidCharacter = localUtils.generateInvalidCharacter
    * def characterTemplates = read('classpath:data/marvel_api/character_templates.json')
    * def characterSchema = read('classpath:data/marvel_api/character_schema.json')
    * def errorSchema = read('classpath:data/marvel_api/error_schema.json')
    * def generarHeaders =
      """
      function() {
        return {
          "Content-Type": "application/json"
        };
      }
      """
    * def headers = generarHeaders()
    * headers headers

  @id:4 @solicitudExitosa201
  Scenario: T-API-H01-CA04-Crear personaje exitoso 201 - karate
    * def randomCharacter = generateRandomCharacter()
    Given path basePath
    And request randomCharacter
    When method POST
    Then status 201
    And match response != null
    And match response.id != null
    And match response == schemaOk()

  @id:5 @nombreDuplicado400
  Scenario: T-API-H01-CA05-Crear personaje con nombre duplicado 400 - karate
    # Primero creamos un personaje con nombre aleatorio
    * def randomCharacter = generateRandomCharacter()
    Given path basePath
    And request randomCharacter
    When method POST
    Then status 201

    # Intentamos crear otro con el mismo nombre
    Given path basePath
    * def duplicateCharacter = randomCharacter
    * set duplicateCharacter.alterego = "Otro"
    * set duplicateCharacter.description = "Otro"
    * set duplicateCharacter.powers = ["Otro"]
    And request duplicateCharacter
    When method POST
    Then status 400
    And match response.error == 'Character name already exists'
    And match response == schemaError()

  @id:6 @camposRequeridosFaltantes400
  Scenario: T-API-H01-CA06-Crear personaje con campos requeridos faltantes 400 - karate
    * def invalidCharacter = generateInvalidCharacter()
    Given path basePath
    And request invalidCharacter
    When method POST
    Then status 400
    And match response.name == 'Name is required'
    And match response.alterego == 'Alterego is required'