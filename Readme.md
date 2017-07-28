# Proyecto de iOS con Firebase expuesto en Oaxacode 2017

# Estructura

1. La presentación está en la carpeta *docs*. La puedes ver corriendo en [este enlace](https://ecamacho.github.io/firebase_ios_oaxacode).
2. El código del proyecto está en *code*

# Cómo correr el proyecto

## Requisitos
1. Necesitas Xcode 9 beta. El proyecto está en Swift 4.
2. Necesitas Cocoapods. Ejecuta `pod install` para descargar las dependencias.
3. Cambia el *bundle id* de la app en `info.plist` a uno único.

## Configuración de Facebook
La app usa Facebook para autenticar usuarios. Debes de crear una app en Facebook y actualizar el archivo *info.plist* con los datos de Facebook. Puedes ver las instrucciones en [el sitio de Facebook](https://developers.facebook.com/docs/facebook-login/ios).

Estas son los valores que deben de agregar al archivo `info.plist`: 
![Instrucciones](https://ecamacho.github.io/firebase_ios_oaxacode/images/fb_config.png)

## Configuración de Firebase
1. Necesitas crear un Proyecto en Firebase.
2. Configura la app iOS dentro del proyecto. Sigue [estas instrucciones](https://firebase.google.com/docs/ios/setup). Asegúrate de bajar el archivo `GoogleService-Info.plist`. El proyecto ya tiene todas las dependencias de Firebase listas, solo necesita que configures tu proyecto en Firebase y agregues ese archivo al proyecto. 
3. Configura *Firebase authentication* con Facebook, [sigue estas instrucciones](https://firebase.google.com/docs/auth/ios/facebook-login).




