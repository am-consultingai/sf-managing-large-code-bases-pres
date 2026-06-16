/**
 * THE DECK CONTENT — this is the only file you edit to create a presentation.
 *
 * Compose branded layouts from "../deck-kit/slides". Each array entry is one
 * slide. Reorder, add, or remove freely. Run `npm run dev` and use → / click
 * to advance. See CLAUDE.md for the full authoring guide and layout reference.
 *
 * The example below is a port of the legacy "Managing large codebases with
 * Claude" deck, rebuilt on the AM Consulting brand — replace it with your own.
 */
import type { Slide } from "../deck-kit/engine/types";
import {
  AboutSlide,
  AgendaSlide,
  BulletSlide,
  ClosingSlide,
  DiagramSlide,
  ProcessSlide,
  QuoteSlide,
  SectionDivider,
  TitleSlide,
} from "../deck-kit/slides";

export const slides: Slide[] = [
  <TitleSlide
    eyebrow="Workshop"
    title="Managing large codebases with"
    highlight="Claude Code"
    subtitle="Context, tools, and the system around the model."
    date="Apr 2026"
  />,

  <AboutSlide
    blurb="The model is rarely the hard part — the system around it is."
    services={[
      { heading: "Execution", items: ["AI & Data — professional services", "AI tools for productivity", "Design → Implementation"] },
      { heading: "Learning", items: ["Tailored courses & workshops", "Guided thinking group for executives", "Technical courses"] },
    ]}
  />,

  <AgendaSlide items={["Context — what it is and why it matters", "Claude's tools: MCPs & Skills", "Building: code with Claude live"]} />,

  <BulletSlide
    eyebrow="Foundations"
    title="The context life cycle"
    bullets={[
      { title: "Transformers", desc: "Predict the next token." },
      { title: "LLM calls", desc: "Run the transformer in a loop to generate a message." },
      { title: "Claude", desc: "Appends each request + answer to the context window, then generates a new response." },
    ]}
  />,

  <BulletSlide
    eyebrow="Operating tip"
    title="When it isn't performing…"
    bullets={["Adjust your request", "Break the request into smaller steps", "Clear the session", "Plan & brainstorm in a separate session"]}
  />,

  <DiagramSlide
    eyebrow="Mental model"
    title="Software uses APIs to communicate"
    nodes={[{ label: "Your App", sub: "client" }, { label: "API", sub: "contract" }, { label: "Gmail / Calendar", sub: "service" }]}
    caption="Every integration is one program calling another's API."
  />,

  <DiagramSlide
    eyebrow="MCP"
    title="MCPs translate a request into an API call"
    nodes={[{ label: "User", sub: "“get John's last email”" }, { label: "MCP Server", sub: "translator" }, { label: "Service API", sub: "Gmail" }]}
  />,

  <ProcessSlide
    eyebrow="Skills"
    title="Skills are instructions (that may call MCPs)"
    steps={[
      { title: "Browse the web for mature, profitable post–Series-B companies" },
      { title: "Identify their CTO / COO / CEO" },
      { title: "Find their LinkedIn profile" },
      { title: "Draft a short, personalized connection request" },
      { title: "Write it all to a Markdown file" },
    ]}
  />,

  <SectionDivider number="01" eyebrow="Demo" title="Let's start" highlight="coding." />,

  <ProcessSlide
    eyebrow="Live build"
    title="Let's write an article"
    steps={[
      { title: "Search the web for us" },
      { title: "Find highly reputable sources" },
      { title: "Draft a plan and wait for confirmation" },
      { title: "Write the article, then translate to Hebrew" },
      { title: "Export to a Word file" },
    ]}
  />,

  <QuoteSlide
    quote="Stop reaching for GenAI by default."
    highlight="Start designing AI-fueled systems."
    attribution="AM Consulting"
  />,

  <ClosingSlide />,
];
