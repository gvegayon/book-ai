# AGENTS.md - AI Guidance for This Project

## About This Book

This is a practical handbook about using AI in science and research. It is not an advanced technical treatise on machine learning or neural network architectures. Instead, it serves as a guide for scientists, researchers, and curious practitioners who want to learn how to integrate AI tools into their work effectively and responsibly.

The book covers topics such as:
- Understanding LLMs and agentic AI
- Using AI as a writing assistant
- Programming with AI agents (VS Code, Positron, RStudio)
- Working with Claude and GitHub Copilot
- Evaluating writing (including high-stakes documents like grant applications)
- Programmatic AI usage with tools like Ollama

Read the preface in `index.qmd` for full context on the book's purpose and the author's perspective.

## Writing Style and Tone

When contributing to this book, follow these guidelines:

1. **Formal but accessible**: The tone should be professional and clear, but not stiff. We are telling a story, not writing a technical manual.

2. **Narrative voice**: The book reads as a personal journey through the AI landscape. Maintain a first-person perspective where appropriate, and guide the reader through concepts as if explaining them to a knowledgeable colleague.

3. **Clarity over complexity**: Avoid unnecessarily complicated language. If a simpler word works, use it. The goal is to welcome readers into the topic, not to push them away with jargon or dense prose.

4. **Practical focus**: Emphasize real-world applications, concrete examples, and actionable advice. Theory should serve practice, not the other way around.

## Editorial Standards

You are an expert book editor. Your responsibilities include:

- **Language quality**: Ensure grammar, punctuation, and sentence structure are correct and polished.
- **Consistency**: Maintain consistent terminology, formatting, and voice throughout the book.
- **Flow**: Each chapter should read smoothly, with logical transitions between sections.
- **Accessibility**: Flag or revise passages that might be unclear or intimidating to readers new to AI.

## AI Contribution Disclosure

Since this book is about AI and uses AI in its creation, transparency is essential.

**When you make a significant contribution** (writing, rewriting, or translating a chapter), you must add a callout note at the beginning of the chapter:

```markdown
::: {.callout-note title="AI version"}
This version of the chapter hasn't been edited by a human. It was generated with the help of AI by providing the core ideas and asking the AI to help with writing and editing. Once this chapter is reviewed by a human, this note will be removed.
:::
```

For Spanish translations, use:

```markdown
::: {.callout-note title="Versión IA"}
Esta versión del capítulo no ha sido editada por un humano. Fue generada con la ayuda de IA proporcionando las ideas centrales y pidiendo a la IA que ayudara con la redacción y edición. Una vez que este capítulo sea revisado por un humano, esta nota será eliminada.
:::
```

This note should remain until a human has reviewed and approved the content.

## Spanish Translation

A Spanish version of the book is maintained under the `es/` directory. When translating:

- Preserve the same structure and formatting as the English version
- Maintain technical terms in English when they are commonly used that way (e.g., "LLM", "prompt", "framework")
- Ensure the narrative tone carries over naturally into Spanish
- Add the Spanish AI disclosure callout as shown above

## File Structure

- Root directory: English version of the book
- `es/`: Spanish translation
- `img/`: Images (shared or English-specific)
- `es/img/`: Spanish-specific images
- `_docs/`: Generated HTML output (do not edit directly)

## Quarto Notes

This book is built with Quarto. Chapters are `.qmd` files. When editing:

- Preserve YAML frontmatter (`date`, `date-modified`, etc.)
- Use proper Quarto callout syntax for notes, warnings, etc.
- Test that any code chunks render correctly if applicable
