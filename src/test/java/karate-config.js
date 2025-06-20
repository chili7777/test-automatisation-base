function fn() {
  var env = karate.env || 'local';

  // Configuración base para todos los entornos
  var config = {
    baseUrl: 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
  };

  // URLs para todos los microservicios (nombrados con formato port_nombre_microservicio)
  config.port_marvel_api = 'http://bp-se-test-cabcd9b246a5.herokuapp.com';

  // SSL configuration to ignore certificate validation
  karate.configure('ssl', true);

  // Function to load utils specific to each feature file
  config.setLocalUtils = function () {
      try {
        const fileUtilsName = `this:${karate.info.featureFileName.replaceAll('.feature', '_utils.js')}`;
        karate.log('[setLocalUtils]: ' + fileUtilsName);
        return karate.read(fileUtilsName);
      } catch (error) {
        karate.log('[No localUtils configured]: ' + error);
        return () => {};
      }
  };

  // Configure random utility using Faker
  config.utils = {};
  config.utils.random = function() {
    let Locale = Java.type('java.util.Locale');
    let Faker = Java.type('net.datafaker.Faker');
    let faker = new Faker(new Locale('en-US'));
    return faker;
  };
  config.random = config.utils.random();

  // Configuración específica por entorno
  if (env == 'dev') {
    config.baseUrl = 'http://bp-se-test-cabcd9b246a5.herokuapp.com';
    config.port_marvel_api = 'http://bp-se-test-cabcd9b246a5.herokuapp.com';
  }
  else if (env == 'qa') {
    config.baseUrl = 'http://bp-se-test-cabcd9b246a5.herokuapp.com';
    config.port_marvel_api = 'http://bp-se-test-cabcd9b246a5.herokuapp.com';
  }

  return config;
}