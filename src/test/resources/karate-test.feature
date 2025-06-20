@REQ_H01 @HU01 @marvel_characters_api @marvel_api @Agente2 @E2 @iniciativa_marvel
Feature: H01 API REST de personajes de Marvel (microservicio para gestión de personajes)

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

  @id:1 @obtenerPersonajes @solicitudExitosa200
  Scenario: T-API-H01-CA01-Obtener todos los personajes 200 - karate
    Given url basePath
    When method GET
    Then status 200
    # And match response != null
    # And match response == '#array'

  @id:2 @obtenerPersonajePorId @solicitudExitosa200
  Scenario: T-API-H01-CA02-Obtener personaje por ID exitoso 200 - karate
    Given url basePath + '/1'
    When method GET
    Then status 200
    # And match response != null
    # And match response.id == 1

  @id:3 @obtenerPersonajePorId @personajeNoExiste404
  Scenario: T-API-H01-CA03-Obtener personaje por ID inexistente 404 - karate
    Given url basePath + '/999'
    When method GET
    Then status 404
    # And match response.error == 'Character not found'
    # And match response == { error: 'Character not found' }

  @id:4 @crearPersonaje @solicitudExitosa201
  Scenario: T-API-H01-CA04-Crear personaje exitoso 201 - karate
    * def randomName = 'Thor_' + java.util.UUID.randomUUID().toString().substring(0, 8)
    Given url basePath
    And request { "name": "#(randomName)", "alterego": "Thor Odinson", "description": "God of Thunder", "powers": ["Lightning", "Mjolnir", "Strength"] }
    When method POST
    Then status 201
    # And match response != null
    # And match response.id != null

  @id:5 @crearPersonaje @nombreDuplicado400
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
    # And match response.error == 'Character name already exists'
    # And match response == { error: 'Character name already exists' }

  @id:6 @crearPersonaje @camposRequeridosFaltantes400
  Scenario: T-API-H01-CA06-Crear personaje con campos requeridos faltantes 400 - karate
    Given url basePath
    And request { "name": "", "alterego": "", "description": "", "powers": [] }
    When method POST
    Then status 400
    # And match response.name == 'Name is required'
    # And match response.alterego == 'Alterego is required'

  @id:7 @actualizarPersonaje @solicitudExitosa200
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
    # And match response.description == 'Updated description'
    # And match response.powers contains 'Regeneration'

  @id:8 @actualizarPersonaje @personajeNoExiste404
  Scenario: T-API-H01-CA08-Actualizar personaje inexistente 404 - karate
    Given url basePath + '/999'
    And request { "name": "No existe", "alterego": "Nadie", "description": "No existe", "powers": ["Nada"] }
    When method PUT
    Then status 404
    # And match response.error == 'Character not found'
    # And match response == { error: 'Character not found' }

  @id:9 @eliminarPersonaje @solicitudExitosa204
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
    # And match response == ''
    # And match responseBytes == '0'

  @id:10 @eliminarPersonaje @personajeNoExiste404
  Scenario: T-API-H01-CA10-Eliminar personaje inexistente 404 - karate
    Given url basePath + '/999'
    When method DELETE
    Then status 404
    # And match response.error == 'Character not found'
    # And match response == { error: 'Character not found' }