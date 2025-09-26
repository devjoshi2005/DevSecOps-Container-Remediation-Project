# Technical Report of DevSecOps-Container-Remediation-Project

![Image](https://github.com/user-attachments/assets/1c710d42-89fe-4a69-9c3d-f6c39e547746)

*Step by Step Execution of this project*

```mermaid
flowchart LR
    A[Step1 : Flask App Prepared in github repository] --> B[Step2: Owasp Zap Scanning is done on the application]
    B --> C[Sonarqube static code analysis (hosted in ec2) is done]
    C --> D[built into docker image and later pushed to ECR and later ECS]
    D --> E[Trivy scans the image pulled from the ECR for misconfigurations,secrets or CVE'S (pre container security scan)]
    E --> F[sonarqube and trivy log values are sent to graylog (hosted in ec2) for log management and analysis ]
    F --> G[codebase is extracted by pulling image in ECR and saved in s3 bucket]
    G --> H[codebase along with sonarqube and trivy log messages ONLY are sent to claude sonnet model accessed using aws bedrock]
    H --> I[Claude sonnet recitifies the code snippets from given data and provides remediated code snippets]
    I --> J[A new commit branch is created from main branch which we send the remediated code snippets from claude as PR]
    J --> A
```




APP DEMO
https://github.com/user-attachments/assets/2fc5c592-3db6-4357-802a-65a8fa9814c1

ECR-ECS LINK
https://github.com/user-attachments/assets/e45fa054-a423-4caa-aa57-a3bd6bc6e8b0

ECR-ECS LINK 2
https://github.com/user-attachments/assets/0efd3bcc-5f37-4b42-80e0-ce690c471630

GITHUB SETUP 1
https://github.com/user-attachments/assets/9b4758a1-0841-4bb7-a1f4-c9607fcde217

IAM NEW USER
https://github.com/user-attachments/assets/9721fabc-3fba-4def-bb8f-b32e37d9eb4f

AWS INSPECTOR SCAN
https://github.com/user-attachments/assets/f7277559-0b03-4001-926d-28d28158643f

OWASP ZAP SCAN
https://github.com/user-attachments/assets/f997280c-bdff-43b1-ad74-a66d499710c3

GRAYLOG SETUP1 
https://github.com/user-attachments/assets/13a844f9-52e8-48de-a6c5-1c6c7f6082da

GRAYLOG SETUP2
https://github.com/user-attachments/assets/7c16f2fa-9a6c-49a7-b079-f25af204d3eb

GRAYLOG SETUP3
https://github.com/user-attachments/assets/fc9abee4-78df-4ab1-bdf2-23c7f705b84c

GRAYLOG SETUP4
https://github.com/user-attachments/assets/51f8a6c7-a522-44cd-8ccc-7d105a9db326

FINAL WORKFLOW
https://github.com/user-attachments/assets/5de26f69-bf7d-4f61-b38b-afe5022700ce
