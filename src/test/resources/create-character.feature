@REQ_H01 @HU01 @marvel_characters_api @marvel_api @Agente2 @E2 @iniciativa_marvel @crearPersonaje
Feature: H01 API REST de personajes de Marvel - Crear personaje

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

  @id:4 @solicitudExitosa201
  Scenario: T-API-H01-CA04-Crear personaje exitoso 201 - karate
    * def randomName = 'Thor_' + java.util.UUID.randomUUID().toString().substring(0, 8)
    Given url basePath
    And request { "name": "#(randomName)", "alterego": "Thor Odinson", "description": "God of Thunder", "powers": ["Lightning", "Mjolnir", "Strength"] }
    When method POST
    Then status 201
    And match response != null
    And match response.id != null

  @id:5 @nombreDuplicado400
  Scenario: T-API-H01-CA05-Crear personaje con nombre duplicado 400 - karate
    # Primero creamos un personaje con nombre aleatorio
    * def randomName = 'SpiderMan_' + java.util.UUID.randomUUID().toString().substring(0, 8)
    Given url basePath
    And request { "name": "#(randomName)", "alterego": "Peter Parker", "description": "Spider powers", "powers": ["Spider-sense", "Wall-crawling"] }
    When method POST
    Then status 201

    # Intentamos crear otro con el mismo nombre
    Given url basePath
    And request { "name": "#(randomName)", "alterego": "Otro", "description": "Otro", "powers": ["Otro"] }
    When method POST
    Then status 400
    And match response.error == 'Character name already exists'
    And match response == { error: 'Character name already exists' }

  @id:6 @camposRequeridosFaltantes400
  Scenario: T-API-H01-CA06-Crear personaje con campos requeridos faltantes 400 - karate
    Given url basePath
    And request { "name": "", "alterego": "", "description": "", "powers": [] }
    When method POST
    Then status 400
    And match response.name == 'Name is required'
    And match response.alterego == 'Alterego is required'