function fndispatcher() {
  // Sample schema for error response
  const schemaError = function () {
    return {
      error: '#string'
    };
  };

  // Generate a random character with Faker for creation before deletion
  const generateRandomCharacterForDeletion = function() {
    const faker = karate.get('random');
    return {
      name: "ToDelete_" + faker.superhero().name() + '_' + faker.number().digits(5),
      alterego: faker.name().fullName(),
      description: faker.lorem().sentence(),
      powers: [
        faker.superhero().power(),
        faker.superhero().power()
      ]
    };
  };

  // Return all utility functions
  return {
    schemaError,
    generateRandomCharacterForDeletion
  };
}