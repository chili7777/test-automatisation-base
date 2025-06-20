@REQ_H01 @HU01 @marvel_characters_api @marvel_api @Agente2 @E2 @iniciativa_marvel @obtenerPersonajes
Feature: H01 API REST de personajes de Marvel - Obtener todos los personajes

  Background:
    * configure ssl = true
    * url port_marvel_api
    * def username = 'hberrezu'
    * def basePath = '/' + username + '/api/characters'
    * path basePath
    * def utils = karate.call('get-characters_utils.js')
    * def schemaOk = utils.schemaOk
    * def schemaError = utils.schemaError
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

  @id:1 @solicitudExitosa200
  Scenario: T-API-H01-CA01-Obtener todos los personajes 200 - karate
    When method GET
    Then status 200
    And match response != null
    And match response == '#array'