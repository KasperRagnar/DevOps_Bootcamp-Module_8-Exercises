#!/user/bin/env groovy

def getPackageVersionNumber() {
    String version = sh 'npm pkg get version';
    version = version.replaceAll("\"", "");
    return version;
}
