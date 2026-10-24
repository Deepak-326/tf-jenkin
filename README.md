# tf-jenkin


# tf-jenkins


### LAUNCH EC2instance 


### Install jenkins 
````
sudo apt update
sudo apt install fontconfig openjdk-21-jre -y
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins -y
````

### Install terraform
````
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform -y
````
### Install AWS CLI 

````
sudo apt install unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

````

###  Create IAM role assign adminacess
- also attach iam role to ec2 instance 
---

### Install following plugins
````
terraform
stage view
````

### manage jenkins >> tools
**terraform** = terraform




---
<img width="1917" height="667" alt="image" src="https://github.com/user-attachments/assets/7e1c1b9f-8524-45b7-92c2-554a0e31dd5a" />

````

pipeline {
    agent any

    tools {
        terraform 'terraform'
    }

    parameters {
        choice(name: 'action', choices: ['apply', 'destroy'])
    }

    stages {
        stage('code-pull') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/abhipraydhoble/tf-jenkins.git'
            }
        }

        stage('init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('apply/destroy') {
            steps {
                input message: "Approve ${params.action}?"
                sh "terraform ${params.action} -auto-approve"
            }
        }
    }
}
````


---

<img width="1917" height="501" alt="image" src="https://github.com/user-attachments/assets/3905d0a4-e896-43f8-9388-ef290f5a19db" />
