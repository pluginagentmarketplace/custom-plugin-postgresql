---
name: data-ai-ml
description: Master data science and machine learning with Python, TensorFlow, PyTorch, and MLOps. Learn to build predictive models, deep learning systems, and production ML pipelines.
---

# Data, AI & Machine Learning

## Quick Start

### Python Data Analysis
```python
import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler

# Load data
df = pd.read_csv('data.csv')

# Exploratory analysis
print(df.describe())
print(df.info())

# Data preprocessing
df = df.dropna()
scaler = StandardScaler()
df_scaled = scaler.fit_transform(df)
```

### Machine Learning Model
```python
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, confusion_matrix

# Split data
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

# Train model
model = RandomForestClassifier(n_estimators=100)
model.fit(X_train, y_train)

# Evaluate
predictions = model.predict(X_test)
accuracy = accuracy_score(y_test, predictions)
print(f'Accuracy: {accuracy}')
```

### Deep Learning with TensorFlow
```python
import tensorflow as tf
from tensorflow import keras

# Build model
model = keras.Sequential([
    keras.layers.Dense(128, activation='relu', input_shape=(784,)),
    keras.layers.Dense(64, activation='relu'),
    keras.layers.Dense(10, activation='softmax')
])

# Compile
model.compile(
    optimizer='adam',
    loss='sparse_categorical_crossentropy',
    metrics=['accuracy']
)

# Train
model.fit(X_train, y_train, epochs=10, batch_size=32)
```

### PyTorch Neural Network
```python
import torch
import torch.nn as nn
from torch.optim import Adam

class NeuralNet(nn.Module):
    def __init__(self):
        super().__init__()
        self.fc1 = nn.Linear(784, 128)
        self.fc2 = nn.Linear(128, 64)
        self.fc3 = nn.Linear(64, 10)

    def forward(self, x):
        x = torch.relu(self.fc1(x))
        x = torch.relu(self.fc2(x))
        return self.fc3(x)
```

### Data Visualization
```python
import matplotlib.pyplot as plt
import seaborn as sns

# Line plot
plt.plot(x, y)
plt.xlabel('Feature')
plt.ylabel('Target')
plt.show()

# Heatmap
sns.heatmap(correlation_matrix, annot=True)
plt.show()
```

## Core Concepts

### 1. Data Fundamentals
- Data collection and cleaning
- Exploratory data analysis
- Data visualization
- Statistical testing
- Missing value handling
- Outlier detection

### 2. Machine Learning
- Supervised learning
- Unsupervised learning
- Regression models
- Classification models
- Clustering algorithms
- Dimensionality reduction

### 3. Deep Learning
- Neural networks
- Convolutional Neural Networks
- Recurrent Neural Networks
- Transformer architectures
- Attention mechanisms
- Transfer learning

### 4. MLOps
- Model versioning
- Experiment tracking
- Model serving
- CI/CD for ML
- Model monitoring
- Retraining strategies

### 5. Advanced Topics
- Natural Language Processing
- Computer Vision
- Recommender Systems
- Reinforcement Learning
- Time Series Forecasting
- Anomaly Detection

## Tools & Libraries

### Python Data Science
- **Pandas**: Data manipulation
- **NumPy**: Numerical computing
- **Scikit-learn**: ML algorithms
- **Matplotlib/Seaborn**: Visualization

### Deep Learning
- **TensorFlow/Keras**: Google's framework
- **PyTorch**: Facebook's framework
- **JAX**: Google's framework

### ML Tools
- **MLflow**: Experiment tracking
- **Weights & Biases**: ML monitoring
- **DVC**: Version control for data
- **Jupyter**: Interactive notebooks

### Data Visualization
- **Tableau**: Business intelligence
- **Power BI**: Microsoft BI
- **Plotly**: Interactive plots

## Common Patterns

### Feature Engineering
- Feature scaling
- Feature selection
- Feature encoding
- Feature creation
- Handling imbalanced data

### Model Evaluation
- Train/validation/test split
- Cross-validation
- Confusion matrix
- ROC curves
- Precision, recall, F1

### Hyperparameter Tuning
- Grid search
- Random search
- Bayesian optimization
- Early stopping

## Projects to Build

1. **Iris Classification**
   - Load dataset
   - Train classifier
   - Evaluate performance

2. **Housing Price Prediction**
   - Linear regression
   - Feature engineering
   - Model evaluation

3. **Image Classification (MNIST)**
   - CNN architecture
   - Training and validation
   - Model deployment

4. **NLP Sentiment Analysis**
   - Text preprocessing
   - Word embeddings
   - Classification model

5. **Time Series Forecasting**
   - ARIMA model
   - LSTM networks
   - Performance metrics

## Interview Tips

### Common ML Questions
- Explain overfitting and underfitting
- What is cross-validation?
- How do you handle imbalanced data?
- Difference between supervised and unsupervised learning
- Explain regularization

### Practical Challenges
- Build end-to-end ML pipeline
- Feature engineering for specific problem
- Model selection and comparison
- Production deployment planning

## Best Practices

- Start simple, iterate gradually
- Monitor for data drift
- Use cross-validation
- Proper train/test splits
- Document experiments
- Version control models
- Automate pipeline

## Advanced Topics

- Ensemble methods
- Gradient boosting (XGBoost, LightGBM)
- Neural architecture search
- Few-shot learning
- Meta-learning
- Federated learning
- Prompt engineering for LLMs

## Performance Optimization

- Batch processing
- GPU acceleration
- Model quantization
- Knowledge distillation
- Parallel processing
- Distributed training

---

For detailed information, visit the **AI Engineer** roadmap at https://roadmap.sh/ai-engineer
