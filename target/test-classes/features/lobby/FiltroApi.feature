Feature: Validación de API Filtros Avanzados

Background:
    * url 'https://c03bd4ncki.execute-api.us-west-2.amazonaws.com/dev'
    * header Content-Type = 'application/json'

Scenario: Obtener catalogo de filtros con lobby válido
    Given path 'lobbies/filter'
    And request
    """
    {
      "lobby": "Lobby Todos Los Juegos Desktop"
    }
    """
    When method post
    Then status 200
    And match response.success == true
    And match response.message == "Success"
    And match response.data != null
    And assert response.data.length > 0

Scenario: Validar error cuando lobby no se envía
    Given path 'lobbies/filter'
    And request
    """
    {}
    """
    When method post
    Then status 400
    And match response.message contains 'Completar'

Scenario: Validar error cuando lobby es inválido
    Given path 'lobbies/filter'
    And request
    """
    {
      "lobby": "Lobby Fake"
    }
    """
    When method post
    Then status 400
    And match response.message contains 'lobby'

Scenario: Buscar juegos con filtros válidos
    Given path 'lobbies/games/search'
    And request
    """
    {
      "lobby": "Lobby Todos Los Juegos Desktop",
      "attractions": ["OPT_atraccion_expanding_wild"],
      "isAscending": true,
      "pageNumber": 1,
      "pageSize": 10
    }
    """
    When method post
    Then status 200
    And match response.data != null
    And match response.totalItems == '#number'
    And match response.totalPages == '#number'

Scenario: Validar error cuando pageSize es mayor a 100
    Given path 'lobbies/games/search'
    And request
    """
    {
      "lobby": "Lobby Todos Los Juegos Desktop",
      "attractions": ["OPT_atraccion_expanding_wild"],
      "pageNumber": 1,
      "pageSize": 200
    }
    """
    When method post
    Then status 400
    And match response.message contains 'pageSize'

Scenario: Validar error cuando pageNumber es menor a 1
    Given path 'lobbies/games/search'
    And request
    """
    {
      "lobby": "Lobby Todos Los Juegos Desktop",
      "attractions": ["OPT_atraccion_expanding_wild"],
      "pageNumber": 0,
      "pageSize": 10
    }
    """
    When method post
    Then status 400
    And match response.message contains 'pageNumber'