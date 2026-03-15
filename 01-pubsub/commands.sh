# =============================
# Google Cloud Pub/Sub Commands
# =============================

# Create Topics
gcloud pubsub topics create myTopic
gcloud pubsub topics list
gcloud pubsub topics delete Test1

# Create Subscriptions
gcloud pubsub subscriptions create --topic myTopic mySubscription
gcloud pubsub topics list-subscriptions myTopic
gcloud pubsub subscriptions delete Test1

# Publish Messages
gcloud pubsub topics publish myTopic --message "Hello"
gcloud pubsub topics publish myTopic --message "Publisher's name is AVINASH the BOSS"

# Pull Messages
gcloud pubsub subscriptions pull mySubscription --auto-ack
gcloud pubsub subscriptions pull mySubscription --limit=3 --auto-ack
