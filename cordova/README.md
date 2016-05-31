
# Como rodar o cordova
## run:
´´´
docker build -t cordova .
´´´
Depois cole essa função no final do seu arquivo ~/.zshrc
´´´
function cordova() {
   docker run -it --rm --privileged -v /dev/bus/usb:/dev/bus/usb -v $PWD:/src -w /src cordova cordova "$@"                                       
}
´´´

E depois rode o comando:
´´´
source ~/.zshrc
´´´

Agora va até a página do projeto e use o comando para verificar se funciona:
´´´
cordova --help
´´´
