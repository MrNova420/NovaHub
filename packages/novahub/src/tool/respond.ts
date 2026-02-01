import z from "zod"
import { Tool } from "./tool"

export const RespondTool = Tool.define("respond", {
  description:
    "Use this to respond with plain text for greetings, acknowledgments, or simple questions. Examples: 'hello', 'thanks', 'what can you do?'",
  parameters: z.object({
    message: z.string().describe("The text message to display to the user"),
  }),
  async execute(params) {
    return {
      title: "",
      output: params.message,
      metadata: {},
    }
  },
})
