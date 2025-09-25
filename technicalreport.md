# Technical Report of DevSecOps-Container-Remediation-Project

![Image](https://github.com/user-attachments/assets/1c710d42-89fe-4a69-9c3d-f6c39e547746)


``` mermaid
flowchart LR
  subgraph Pre-Remediation
    style Pre-Remediation fill:#ececec,stroke:#333,stroke-width:1px
    A[Developer: Flask + HTML/CSS code]:::pre --> B[GitHub Actions CI]:::pre
    B --> C[OWASP ZAP runtime pen test]:::pre
    B --> D[SonarQube static analysis (EC2)]:::pre
    D --> H[Graylog (EC2) logs]:::pre
    C --> H
    B --> E[Docker build (multi-stage)]:::pre
    E --> F[Push image to ECR]:::pre
    F --> G[ECS deploy (canary/blue-green)]:::post
    F --> T[Trivy image scan]:::pre
    T --> H
  end

  subgraph Remediation
    style Remediation fill:#fde7e7,stroke:#c00,stroke-width:1px
    F --> X[Extract code from image layers]:::rem
    X --> S3[S3 snapshot (tar.gz)]:::rem
    H --> Bed[Bedrock: Claude Sonnet model]:::rem
    S3 --> Bed
    Bed --> PR[Create remediation branch + PR]:::rem
    PR --> B
  end

  subgraph Post-Remediation
    style Post-Remediation fill:#e8f7e9,stroke:#155724,stroke-width:1px
    G --> Inspector[AWS Inspector continuous scans]:::post
    Inspector --> H
    G --> H
  end

  classDef pre fill:#d9d9d9,stroke:#333,color:#000;
  classDef rem fill:#f8d7da,stroke:#c00,color:#000;
  classDef post fill:#d4edda,stroke:#155724,color:#000;



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
