function fndispatcher() {
  // Sample data for updating a character
  const bodyUpdateCharacter = {
    name: "Iron Man",
    alterego: "Tony Stark",
    description: "Updated description",
    powers: ["Armor", "Flight", "Intelligence"]
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

  // Generate a random character with Faker for update
  const generateRandomCharacterUpdate = function() {
    const faker = karate.get('random');
    return {
      name: faker.superhero().name() + '_' + faker.number().digits(5),
      alterego: faker.name().fullName(),
      description: "Updated: " + faker.lorem().sentence(),
      powers: [
        faker.superhero().power(),
        faker.superhero().power(),
        "Updated Power"
      ]
    };
  };

  // Return all utility functions
  return {
    bodyUpdateCharacter,
    schemaOk,
    schemaError,
    generateRandomCharacterUpdate
  };
}