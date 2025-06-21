from fastapi import FastAPI
from pydantic import BaseModel
from transformers import pipeline
import torch

#Initialize the sentiment analysis pipeline
#This downloads the pre-trained model and its tokenizer,
#and sets up everyhting needed for sentiment prediction 
#The default model for sentiment analysis is 'distilbert-base-uncased-finetuned-sst-2-english'.

#pipeline function builds a pipeline for the task specified using the model
#If a model is not specified, the default model for the task will be used.
classifier = pipeline("sentiment-analysis",model="distilbert-base-uncased-finetuned-sst-2-english")

#Create a FastAPI application
app = FastAPI(title="Sentiment Analysis API", description="API for classifying text sentiment using a pre-trained Hugging Face model")

#Define the input data model
class CallInput(BaseModel):
    Text:str

#Define the API endpoint
@app.post("/classify")
async def classify_text_api(item:CallInput):
    results = classifier(item.Text)
    return {"prediction": results[0]}

#Health check
@app.get("/")
async def health_check():
    return  {"message":"Health check successful!" }

def classify_text(text: str):

    results = classifier(text)
    # The pipeline returns a list of dictionaries, e.g.,
    # [{'label': 'POSITIVE', 'score': 0.999}]
    return results[0]

if __name__ == "__main__":

    input_positive = "This is a project."
    prediction_positive =  classify_text(input_positive)
    print(f"Positive Input: '{input_positive}'")
    print(f"Prediction: {prediction_positive}")

    input_negative = "This project is mediocre"
    prediction_negative = classify_text(input_negative)
    print(f"Negative Input: '{input_negative}'")
    print(f"Prediction: {prediction_negative}")