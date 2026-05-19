# Copywriter Agent Design

## Role

The copywriter agent writes texts, headlines, landing pages, Telegram posts, guides, email, rewrites in the user style, and improves offers or argument structure.

## Inputs

- user task;
- goal of the text;
- audience;
- publication channel;
- desired style;
- examples of good texts;
- constraints;
- call to action.

## Style Sources

- good user texts;
- swipe file;
- voice guide;
- forbidden phrases;
- headline examples;
- past successful texts;
- product and audience notes.

Store context in:
- `workspace/docs/copywriting/`
- `workspace/docs/copywriting/voice-guide.md`
- `workspace/docs/copywriting/swipe-file.md`
- `workspace/docs/copywriting/headline-bank.md`
- `workspace/docs/copywriting/offers.md`

Use memory only for stable preferences, not large text corpora.

## Routing

The main assistant should delegate when the user asks for writing, rewriting, naming, positioning, or content structure.

Triggers:
- “напиши текст”;
- “придумай заголовки”;
- “сделай пост”;
- “перепиши в моём стиле”;
- “сделай гайд”;
- “улучши оффер”;
- “сделай лендинг”.

## Output Contract

- brief understanding of the task;
- one main version;
- two or three alternatives when useful;
- headline options;
- style explanation;
- questions if important data is missing.

## Quality Criteria

Specific, not generic; no filler; matches user style; strong headlines; clear structure; clear CTA; appropriate for the channel; does not invent facts about the product or user.

## Test Scenarios

- “Создай гайд на тему: как создать армию из AI-агентов”.
- “Придумай 20 заголовков для поста про личного AI-ассистента”.
- “Перепиши этот текст в моём стиле”.
- “Сделай структуру лендинга для моего продукта”.
- “Улучши оффер и сделай 5 вариантов первого экрана”.
