# DevSecOps-Container-Remediation-Project

```mermaid
flowchart LR
    %% Pre-remediation (light gray/blackish)
    A[Flask App Prepared]:::pre --> B[SonarQube Static Code Analysis]:::pre
    B --> C[OWASP ZAP Pen Testing]:::pre
    C --> D[Build Docker Image]:::pre
    D --> E[ECR Repository]:::pre
    E --> F[ECS Deployment]:::post

    %% Security scans
    E --> G[Trivy Repository Scan]:::pre
    G --> H[Graylog - Security Logs]:::pre
    B --> H
    G --> I[Codebase Extracted from ECR]:::pre
    I --> J[S3 Snapshot Storage]:::pre

    %% Remediation (red)
    J --> K[Claude Model (AWS Bedrock)]:::rem
    H --> K
    K --> L[Rectified Code Snippets]:::rem
    L --> M[GitHub PR to New Branch from Main]:::rem

    %% Post-remediation (green)
    E --> N[AWS Inspector Continuous Scan]:::post
    F --> N

    %% Styles
    classDef pre fill:#d9d9d9,stroke:#333,stroke-width:1px,color:#000;
    classDef rem fill:#f8d7da,stroke:#c00,stroke-width:1px,color:#000;
    classDef post fill:#d4edda,stroke:#155724,stroke-width:1px,color:#000;
