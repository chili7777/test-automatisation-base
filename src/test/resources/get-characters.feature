@REQ_H01 @HU01 @marvel_characters_api @marvel_api @Agente2 @E2 @iniciativa_marvel @obtenerPersonajes
Feature: H01 API REST de personajes de Marvel - Obtener todos los personajes

  Background:
    * configure ssl = true
    * def baseUrl = 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
    * def username = 'hberrezu'
    * def basePath = baseUrl + '/' + username + '/api/characters'
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
    Given url basePath
    When method GET
    Then status 200
    And match response != null
    And match response == '#array'