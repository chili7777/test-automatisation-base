function fndispatcher() {
  // Sample schema for successful response
  const schemaOk = function () {
    return {
      id: '#number',
      name: '#string',
      alterego: '#string',
      description: '#string',
      powers: '#array'
    };
  };

  // Sample schema for error response
  const schemaError = function () {
    return {
      error: '#string'
    };
  };

  // Generate a random character ID
  const generateRandomId = function() {
    const faker = karate.get('random');
    return faker.number().numberBetween(1, 100);
  };

  // Return all utility functions
  return {
    schemaOk,
    schemaError,
    generateRandomId
  };
}