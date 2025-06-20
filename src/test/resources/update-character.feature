@REQ_H01 @HU01 @marvel_characters_api @marvel_api @Agente2 @E2 @iniciativa_marvel @actualizarPersonaje
Feature: H01 API REST de personajes de Marvel - Actualizar personaje

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

  @id:7 @solicitudExitosa200
  Scenario: T-API-H01-CA07-Actualizar personaje exitoso 200 - karate
    # Primero creamos un personaje con nombre aleatorio
    * def randomName = 'Hulk_' + java.util.UUID.randomUUID().toString().substring(0, 8)
    Given url basePath
    And request { "name": "#(randomName)", "alterego": "Bruce Banner", "description": "Green monster", "powers": ["Strength", "Durability"] }
    When method POST
    Then status 201
    * def personajeId = response.id

    # Actualizamos el personaje
    Given url basePath + '/' + personajeId
    And request { "name": "#(randomName)", "alterego": "Bruce Banner", "description": "Updated description", "powers": ["Strength", "Durability", "Regeneration"] }
    When method PUT
    Then status 200
    And match response.description == 'Updated description'
    And match response.powers contains 'Regeneration'

  @id:8 @personajeNoExiste404
  Scenario: T-API-H01-CA08-Actualizar personaje inexistente 404 - karate
    Given url basePath + '/999'
    And request { "name": "No existe", "alterego": "Nadie", "description": "No existe", "powers": ["Nada"] }
    When method PUT
    Then status 404
    And match response.error == 'Character not found'
    And match response == { error: 'Character not found' }