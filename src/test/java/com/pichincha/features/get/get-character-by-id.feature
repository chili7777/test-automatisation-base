@REQ_H01 @HU01 @marvel_characters_api @marvel_api @Agente2 @E2 @iniciativa_marvel @obtenerPersonajePorId
Feature: H01 API REST de personajes de Marvel - Obtener personaje por ID

  Background:
    * configure ssl = true
    * url port_marvel_api
    * def username = 'hberrezu'
    * def basePath = '/' + username + '/api/characters'
    * copy localUtils = call setLocalUtils()
    * def schemaOk = localUtils.schemaOk
    * def schemaError = localUtils.schemaError
    * def generateRandomId = localUtils.generateRandomId
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

  @id:2 @solicitudExitosa200
  Scenario: T-API-H01-CA02-Obtener personaje por ID exitoso 200 - karate
    Given path basePath + '/1'
    When method GET
    Then status 200
    And match response != null
    And match response.id == 1
    And match response == schemaOk()

  @id:3 @personajeNoExiste404
  Scenario: T-API-H01-CA03-Obtener personaje por ID inexistente 404 - karate
    Given path basePath + '/999'
    When method GET
    Then status 404
    And match response.error == 'Character not found'
    And match response == schemaError()