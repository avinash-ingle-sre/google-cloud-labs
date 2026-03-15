# Task 1 - IAM Threat
# IAM > demouser1@gmail.com > BigQuery Admin > Save
# SCC Findings > Non org IAM member (Security Health Analytics)
# SCC Findings > Persistence: IAM anomalous grant (Event Threat Detection)
# IAM > Remove Access > demouser1@gmail.com ✅

# Task 2 - Service Account Self-Investigation  
# Audit Logs > Cloud Resource Manager API > Admin Read > Save
# VM Create > Allow full access to all Cloud APIs
gcloud projects get-iam-policy $(gcloud config get project)
# SCC > Discovery: Service Account Self-Investigation > Mute ✅

# Task 3 - Malware Bad Domain
# Cloud DNS > dns-test-policy > Logs ON > Network: default
curl etd-malware-trigger.goog
# SCC > Malware: Bad Domain > Mute ✅
# VM Delete ✅
