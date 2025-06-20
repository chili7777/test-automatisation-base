@REQ_H01 @HU01 @marvel_characters_api @marvel_api @Agente2 @E2 @iniciativa_marvel @obtenerPersonajePorId
Feature: H01 API REST de personajes de Marvel - Obtener personaje por ID

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

  @id:2 @solicitudExitosa200
  Scenario: T-API-H01-CA02-Obtener personaje por ID exitoso 200 - karate
    Given url basePath + '/1'
    When method GET
    Then status 200
    And match response != null
    And match response.id == 1

  @id:3 @personajeNoExiste404
  Scenario: T-API-H01-CA03-Obtener personaje por ID inexistente 404 - karate
    Given url basePath + '/999'
    When method GET
    Then status 404
    And match response.error == 'Character not found'
    And match response == { error: 'Character not found' }