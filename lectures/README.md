# CS330 Lecture Materials

This directory contains lecture slides, notes, and supplementary materials for CS330.

## Lecture Schedule

### Module 1: Introduction and Foundations

**Lecture 1: Introduction to Multi-Task Learning**
- What is multi-task learning?
- Motivation and applications
- Hard vs. soft parameter sharing
- Task relationships

**Lecture 2: Transfer Learning Fundamentals**
- Domain adaptation
- Fine-tuning pretrained models
- When does transfer learning help?
- Negative transfer

### Module 2: Meta-Learning Basics

**Lecture 3: Introduction to Meta-Learning**
- Problem formulation
- Support and query sets
- N-way K-shot learning
- Common benchmarks (Omniglot, miniImageNet)

**Lecture 4: Meta-Learning Landscape**
- Optimization-based methods
- Metric-based methods
- Model-based methods
- Hybrid approaches

### Module 3: Optimization-Based Meta-Learning

**Lecture 5: Model-Agnostic Meta-Learning (MAML)**
- MAML algorithm
- Second-order derivatives
- Implementation details
- Pros and cons

**Lecture 6: First-Order MAML and Variants**
- First-order MAML (FOMAML)
- Reptile
- MAML++
- Computational considerations

### Module 4: Metric Learning

**Lecture 7: Metric-Based Meta-Learning**
- Siamese networks
- Prototypical networks
- Relation networks
- Distance metrics

**Lecture 8: Few-Shot Classification**
- Matching networks
- Class-level embeddings
- Attention mechanisms
- Transductive inference

### Module 5: Advanced Topics

**Lecture 9: Meta-Reinforcement Learning**
- RL problem setup
- Meta-RL formulation
- MAML for RL
- Applications

**Lecture 10: Recent Advances**
- Meta-learning with neural processes
- Bayesian approaches
- Task-conditioned architectures
- Open problems and future directions

## Lecture Format

Each lecture folder contains:
- `slides.pdf`: Lecture presentation
- `notes.md`: Detailed lecture notes
- `code_examples/`: Runnable code examples
- `readings.md`: Recommended papers and resources

## Accessing Materials

Lecture materials will be posted before each class. It's recommended to:
1. Review slides before class
2. Attend the lecture
3. Review notes and code examples after class
4. Complete the recommended readings

## Additional Resources

- Recorded lectures (if available) will be linked in each lecture folder
- Interactive notebooks demonstrating key concepts
- Links to relevant research papers

## Lecture Notes Guidelines

When taking your own notes:
- Focus on understanding concepts, not copying slides
- Note down examples and intuitions
- Write down questions to ask in office hours
- Connect concepts to previous lectures

## Code Examples

Code examples are provided to demonstrate:
- Algorithm implementations
- Common pitfalls and debugging tips
- Visualization of results
- Practical applications

To run the examples:
```bash
cd lectures/lectureX/code_examples/
python example_script.py
```

## Readings

Recommended papers for each lecture can be found in the respective lecture folders. Papers are categorized as:
- **Core**: Essential reading for understanding the topic
- **Supplementary**: Additional depth and context
- **Advanced**: For students interested in research

## Questions and Discussion

- Ask questions during lectures
- Use the course forum for clarifications
- Attend office hours for deeper discussion
- Form study groups with classmates
