# 🤖 Pre- Text Classifier API

This project is a RESTful API built with **FastAPI** that performs sentiment analysis on text. It demonstrates the ability to build and deploy a modern AI service by combining a high-performance API with a powerful pre-trained deep learning model.

***

### ✨ Key Features

* **RESTful API:** A clean, well-documented API for sentiment analysis with a Swagger UI.
* **Transfer Learning:** Leverages a pre-trained model from Hugging Face, enabling high performance without extensive data or training.
* **Production-Ready Stack:** Uses modern, fast technologies like **FastAPI**, **Uvicorn**, and **PyTorch**.
* **Containerized:** The entire application is packaged with Docker for seamless reproducibility and easy deployment.

***

### 🚀 Getting Started

The easiest way to run this API is with Docker, which handles all dependencies for you. Make sure you have Docker Desktop installed.

1.  **Build the Docker image:**

    ```bash
    docker build -t text-classifier-api .
    ```

2.  **Run the container:** This maps the API to port `8000` on your local machine.

    ```bash
    docker run -d -p 8000:8000 --name my-classifier-app text-classifier-api
    ```

3.  **Use the API:** Open your browser to **`http://localhost:8000/docs`** to view the interactive documentation and test the `/classify` endpoint.

***

### 🛠️ Technologies Used

* **FastAPI:** High-performance Python web framework.
* **PyTorch & Transformers:** For the core AI model (a pre-trained DistilBERT).
* **Uvicorn:** The ASGI server that runs the application.
* **Docker:** For containerization and easy deployment.

***

### 🧠 How It Works

The API uses **transfer learning**, a powerful technique in modern AI. Instead of training a model from scratch, it utilizes a pre-trained model from the Hugging Face hub. This model has already learned a deep understanding of language and has been fine-tuned for the specific task of **sentiment analysis**. This approach makes the model both efficient and highly accurate.

***

### 🚀 Future Enhancements

* Add a simple web interface for easy, visual interaction.
* Implement zero-shot classification to allow custom classification categories.
* Containerize with Docker Compose for multi-service applications.
* Deploy the API to a cloud service like AWS or Hugging Face Spaces.