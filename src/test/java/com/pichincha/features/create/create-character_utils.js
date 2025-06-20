function fndispatcher() {
  // Sample data for a character
  const bodyCreateCharacter = {
    name: "Iron Man",
    alterego: "Tony Stark",
    description: "Genius billionaire",
    powers: ["Armor", "Flight"]
  };

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

  // Generate a random character with Faker
  const generateRandomCharacter = function() {
    const faker = karate.get('random');
    return {
      name: faker.superhero().name() + '_' + faker.number().digits(5),
      alterego: faker.name().fullName(),
      description: faker.lorem().sentence(),
      powers: [
        faker.superhero().power(),
        faker.superhero().power()
      ]
    };
  };

  // Generate an invalid character (empty fields)
  const generateInvalidCharacter = function() {
    return {
      name: "",
      alterego: "",
      description: "",
      powers: []
    };
  };

  // Return all utility functions
  return {
    bodyCreateCharacter,
    schemaOk,
    schemaError,
    generateRandomCharacter,
    generateInvalidCharacter
  };
}