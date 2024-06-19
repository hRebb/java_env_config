{ pkgs ? import <nixpkgs> {} }:

let
  maven = pkgs.maven;
  jdk = pkgs.openjdk;
in
pkgs.stdenv.mkDerivation {
  name = "spring-boot-project";

  # Définir les dépendances nécessaires
  buildInputs = [ maven jdk ];

  # Chemin vers le répertoire contenant le fichier pom.xml
  src = ./.;

  # Commandes pour construire et exécuter le projet
  buildPhase = ''
    mvn clean package
  '';

  installPhase = ''
    mkdir -p $out/lib
    cp target/*.jar $out/lib/
  '';

  # Commande pour exécuter le projet
  shellHook = ''
    java -jar $out/lib/*.jar
  '';
}
