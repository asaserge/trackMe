import 'package:get/get.dart';

import 'constants.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'auth': 'Authenticate',
      'welcome': 'Welcome to $appName, \nThe best tracking system in Cameroon',
      'login': 'Login',
      'register': 'Register',
      'email': 'Email',
      'enter-email': 'Enter your email',
      'valid-email': 'Enter a valid email',
      'password': 'Password',
      'enter-pass': 'Password is required!',
      'wait': 'Please wait...',
      'ok': 'Got it!',
      'help': 'Help',
      'help-text': 'Login to your account if you already have one, if not, contact the admin on +237 651565843 to get a free account. After login in, you will get real time information about your vehicle like speed, live location, position, previous routes and even shutdown the vehicle in case of theft or be notified in case of accidents!',
      'slogan': 'We track everything movable',
      'power': 'Powered by Tembuck',
      'dark': 'Dark Mode',
      'no-pair': 'No paired vehicle!',

    },
    'fr_FR': {
      'auth': 'Authentification',
      'welcome': 'Bienvenue à $appName \nLe meilleur système de suivi au Cameroun',
      'login': 'Connexion',
      'register': 'S\'inscrire',
      'email': 'E-mail',
      'enter-email': 'Entrer votre Email',
      'valid-email': 'Entrer un email valide',
      'password': 'Mot de passe',
      'enter-pass': 'Mot de passe requis!',
      'wait': 'S\'il vous plaît, attendez',
      'ok': 'J\'ai compris',
      'help': 'Aider',
      'help-text': 'Connectez-vous à votre compte si vous en avez déjà un, sinon, contactez l\'administrateur au +237 651565843 pour obtenir un compte gratuit. Après vous être connecté, vous obtiendrez des informations en temps réel sur votre véhicule comme la vitesse, l\'emplacement en direct, la position, les itinéraires précédents et même arrêter le véhicule en cas de vol ou être averti en cas d\'accident!',
      'slogan': 'Nous suivons tout ce qui est mobile',
      'power': 'Propulsé par Tembuck',
      'dark': 'Mode sombre',
      'no-pair': 'Pas de vecule couple!',
    }
  };
}