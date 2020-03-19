pipeline {
 agent any
 stages {
 stage('Checkout') {
 steps {
 git 'https://github.com/mihaelaiovu/TestExcercises.git'
 }
 }
 stage('Build') {
 steps {
 bat "c:\\Users\\Miki\\apache-maven-3.6.3-bin\\apache-maven-3.6.3\\bin\\mvn compile"
 }
 }
 stage('Test') {
 steps {
 bat "c:\\Users\\Miki\\apache-maven-3.6.3-bin\\apache-maven-3.6.3\\bin\\mvn test"
 }
 stage('newman') {
   steps {
   sh 'newman run Restful_Booker_Facit.postman_collection.json --environment Restful_Booker.postman_environment.json --reporters junit'
   }
 post {
 always {
 junit '**/TEST*.xml'
 }
 }
 }
 }
}