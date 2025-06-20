@REQ_H01 @HU01 @marvel_characters_api @marvel_api @Agente2 @E2 @iniciativa_marvel @eliminarPersonaje
Feature: H01 API REST de personajes de Marvel - Eliminar personaje

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

  @id:9 @solicitudExitosa204
  Scenario: T-API-H01-CA09-Eliminar personaje exitoso 204 - karate
    # Primero creamos un personaje con nombre aleatorio
    * def randomName = 'Captain_' + java.util.UUID.randomUUID().toString().substring(0, 8)
    Given url basePath
    And request { "name": "#(randomName)", "alterego": "Steve Rogers", "description": "Super soldier", "powers": ["Strength", "Shield"] }
    When method POST
    Then status 201
    * def personajeId = response.id

    # Eliminamos el personaje
    Given url basePath + '/' + personajeId
    When method DELETE
    Then status 204
    # For 204 No Content responses, we don't need to check the response body
    # as it should be empty by definition

  @id:10 @personajeNoExiste404
  Scenario: T-API-H01-CA10-Eliminar personaje inexistente 404 - karate
    Given url basePath + '/999'
    When method DELETE
    Then status 404
    And match response.error == 'Character not found'
    And match response == { error: 'Character not found' }