@REQ_H01 @HU01 @marvel_characters_api @marvel_api @Agente2 @E2 @iniciativa_marvel @actualizarPersonaje
Feature: H01 API REST de personajes de Marvel - Actualizar personaje

  Background:
    * configure ssl = true
    * url port_marvel_api
    * def username = 'hberrezu'
    * def basePath = '/' + username + '/api/characters'
    * copy localUtils = call setLocalUtils()
    * def schemaOk = localUtils.schemaOk
    * def schemaError = localUtils.schemaError
    * def generateRandomCharacterUpdate = localUtils.generateRandomCharacterUpdate
    * def createUtilsPath = '../create/create-character_utils.js'
    * def createUtils = karate.call(createUtilsPath)
    * def generateRandomCharacter = createUtils.generateRandomCharacter
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

  @id:7 @solicitudExitosa200
  Scenario: T-API-H01-CA07-Actualizar personaje exitoso 200 - karate
    # Primero creamos un personaje con nombre aleatorio
    * def randomCharacter = generateRandomCharacter()
    Given path basePath
    And request randomCharacter
    When method POST
    Then status 201
    * def personajeId = response.id
    * def characterName = response.name

    # Actualizamos el personaje
    * def updateCharacter = generateRandomCharacterUpdate()
    * set updateCharacter.name = characterName
    Given path basePath + '/' + personajeId
    And request updateCharacter
    When method PUT
    Then status 200
    And match response.description contains 'Updated'
    And match response.powers contains 'Updated Power'
    And match response == schemaOk()

  @id:8 @personajeNoExiste404
  Scenario: T-API-H01-CA08-Actualizar personaje inexistente 404 - karate
    * def nonExistentCharacter = generateRandomCharacterUpdate()
    Given path basePath + '/999'
    And request nonExistentCharacter
    When method PUT
    Then status 404
    And match response.error == 'Character not found'
    And match response == schemaError()