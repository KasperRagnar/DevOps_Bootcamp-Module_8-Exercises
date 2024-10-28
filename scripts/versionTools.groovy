#!/user/bin/env groovy

def getPackageVersionNumber() {
    def version = sh 'npm pkg get version';
    return version.replaceAll("\"", "");
}
