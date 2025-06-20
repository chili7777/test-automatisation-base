@REQ_H01 @HU01 @marvel_characters_api @marvel_api @Agente2 @E2 @iniciativa_marvel @eliminarPersonaje
Feature: H01 API REST de personajes de Marvel - Eliminar personaje

  Background:
    * configure ssl = true
    * url port_marvel_api
    * def username = 'hberrezu'
    * def basePath = '/' + username + '/api/characters'
    * copy localUtils = call setLocalUtils()
    * def schemaError = localUtils.schemaError
    * def generateRandomCharacterForDeletion = localUtils.generateRandomCharacterForDeletion
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

  @id:9 @solicitudExitosa204
  Scenario: T-API-H01-CA09-Eliminar personaje exitoso 204 - karate
    # Primero creamos un personaje con nombre aleatorio
    * def randomCharacter = generateRandomCharacterForDeletion()
    Given path basePath
    And request randomCharacter
    When method POST
    Then status 201
    * def personajeId = response.id

    # Eliminamos el personaje
    Given path basePath + '/' + personajeId
    When method DELETE
    Then status 204
    # For 204 No Content responses, we don't need to check the response body
    # as it should be empty by definition

  @id:10 @personajeNoExiste404
  Scenario: T-API-H01-CA10-Eliminar personaje inexistente 404 - karate
    Given path basePath + '/999'
    When method DELETE
    Then status 404
    And match response.error == 'Character not found'
    And match response == schemaError()