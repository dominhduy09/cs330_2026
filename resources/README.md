# CS330 Learning Resources

This directory contains additional learning resources, papers, and references for CS330.

## Core Textbooks and Surveys

### Recommended Reading

1. **Deep Learning** by Goodfellow, Bengio, and Courville
   - Chapters on optimization and neural networks
   - Available online: [https://www.deeplearningbook.org/](https://www.deeplearningbook.org/)

2. **Meta-Learning: A Survey** by Joaquin Vanschoren
   - Comprehensive overview of meta-learning
   - arXiv: 1810.03548

3. **A Survey of Deep Meta-Learning** by Huisman et al.
   - Recent advances in deep meta-learning
   - arXiv: 2010.03522

## Foundational Papers

### Multi-Task Learning

- **Multi-Task Learning** by Rich Caruana (1997)
  - Classic paper introducing MTL concepts

- **An Overview of Multi-Task Learning in Deep Neural Networks** by Sebastian Ruder (2017)
  - Modern perspective on MTL with deep learning
  - arXiv: 1706.05098

### Meta-Learning

- **Model-Agnostic Meta-Learning (MAML)** by Finn et al. (2017)
  - ICML 2017
  - arXiv: 1703.03400

- **Matching Networks for One Shot Learning** by Vinyals et al. (2016)
  - NeurIPS 2016
  - arXiv: 1606.04080

- **Prototypical Networks for Few-shot Learning** by Snell et al. (2017)
  - NeurIPS 2017
  - arXiv: 1703.05175

- **Optimization as a Model for Few-Shot Learning** by Ravi & Larochelle (2017)
  - ICLR 2017

### Transfer Learning

- **A Survey on Transfer Learning** by Pan & Yang (2010)
  - IEEE TKDE
  - Comprehensive transfer learning overview

- **Taskonomy: Disentangling Task Transfer Learning** by Zamir et al. (2018)
  - CVPR 2018
  - Understanding task relationships

## Online Courses and Tutorials

1. **CS330 (Stanford)**: Deep Multi-Task and Meta Learning
   - Course website with lectures and materials

2. **PyTorch Tutorials**: Meta-Learning
   - Official PyTorch meta-learning examples

3. **Fast.ai**: Transfer Learning and Fine-tuning
   - Practical deep learning course

## Datasets

### Few-Shot Learning Benchmarks

- **Omniglot**: Handwritten character dataset
  - 1623 characters from 50 alphabets
  - Standard few-shot benchmark

- **miniImageNet**: Subset of ImageNet
  - 100 classes, 600 examples per class
  - Common for 5-way 1-shot and 5-shot tasks

- **tieredImageNet**: Larger ImageNet subset
  - Hierarchical class structure
  - More challenging than miniImageNet

- **Meta-Dataset**: Large-scale diverse dataset
  - Multiple domains
  - Realistic meta-learning evaluation

### Multi-Task Learning Datasets

- **CelebA**: Face attributes
  - Multiple facial attributes
  - Multi-task facial analysis

- **NYU Depth v2**: Scene understanding
  - Depth, surface normals, semantic segmentation
  - Indoor scene analysis

## Code Repositories

### Meta-Learning Libraries

1. **learn2learn**: PyTorch meta-learning library
   - GitHub: [learnables/learn2learn](https://github.com/learnables/learn2learn)
   - Easy-to-use MAML implementations

2. **higher**: PyTorch higher-order optimization
   - GitHub: [facebookresearch/higher](https://github.com/facebookresearch/higher)
   - For implementing MAML and similar algorithms

3. **Torchmeta**: PyTorch meta-learning datasets
   - GitHub: [tristandeleu/pytorch-meta](https://github.com/tristandeleu/pytorch-meta)
   - Standardized meta-learning datasets

### Reference Implementations

- MAML: Original TensorFlow implementation
- Prototypical Networks: PyTorch implementation
- Matching Networks: Torch implementation

## Research Groups and Labs

- Stanford AI Lab (SAIL)
- Berkeley AI Research (BAIR)
- DeepMind
- OpenAI
- FAIR (Facebook AI Research)

## Conferences and Journals

### Top Venues for Meta-Learning Research

- **NeurIPS**: Neural Information Processing Systems
- **ICML**: International Conference on Machine Learning
- **ICLR**: International Conference on Learning Representations
- **CVPR**: Computer Vision and Pattern Recognition
- **AAAI**: Association for the Advancement of AI

## Tools and Frameworks

### Deep Learning Frameworks

- PyTorch (recommended for this course)
- TensorFlow/JAX
- MXNet

### Experiment Tracking

- Weights & Biases
- TensorBoard
- MLflow

### Visualization

- Matplotlib
- Seaborn
- Plotly

## Study Tips

1. **Read Papers Actively**
   - Understand the problem being solved
   - Grasp the key intuition
   - Examine experimental results critically

2. **Implement from Scratch**
   - Best way to understand algorithms
   - Start simple, add complexity gradually

3. **Experiment**
   - Try different hyperparameters
   - Visualize intermediate results
   - Compare with baselines

4. **Stay Updated**
   - Follow arXiv for recent papers
   - Attend conference talks (virtual or in-person)
   - Join online communities

## Additional Resources

### Blogs and Tutorials

- **The Batch** by deeplearning.ai
- **Distill.pub**: Visual explanations of ML concepts
- **Towards Data Science**: Meta-learning articles

### Podcasts

- **TWIML AI Podcast**: Machine Learning Interviews
- **Gradient Dissent**: Weights & Biases podcast

### Communities

- Reddit: r/MachineLearning
- Twitter: #MetaLearning hashtag
- Papers with Code: Meta-learning section

## Contributing

If you find useful resources, please share them with the class through the course forum!
