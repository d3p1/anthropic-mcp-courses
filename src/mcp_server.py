from pydantic import Field
from mcp.server.fastmcp import FastMCP

mcp = FastMCP("DocumentMCP", log_level="ERROR")


docs = {
    "deposition.md": "This deposition covers the testimony of Angela Smith, P.E.",
    "report.pdf": "The report details the state of a 20m condenser tower.",
    "financials.docx": "These financials outline the project's budget and expenditures.",
    "outlook.pdf": "This document presents the projected future performance of the system.",
    "plan.md": "The plan outlines the steps for the project's implementation.",
    "spec.txt": "These specifications define the technical requirements for the equipment.",
}


@mcp.tool(
    name="read_document",
    description="Read the content of a document."
)
def read_document(
    doc_id: str = Field(description="The document ID"),
):
    if doc_id not in docs:
        raise ValueError(f"The document ID {doc_id} does not exist.")
    return docs[doc_id]

@mcp.tool(
    name="edit_document",
    description="Edit the content of a document."
)
def edit_document(
    doc_id: str = Field(description="The document ID"),
    old_string: str = Field(description="The string to edit."),
    new_string: str = Field(description="The string to add."),
):
    if doc_id not in docs:
        raise ValueError(f"The document ID {doc_id} does not exist.")
    docs[doc_id] = docs[doc_id].replace(old_string, new_string)

# TODO: Write a resource to return all doc id's
# TODO: Write a resource to return the contents of a particular doc
# TODO: Write a prompt to rewrite a doc in markdown format
# TODO: Write a prompt to summarize a doc


if __name__ == "__main__":
    mcp.run(transport="stdio")
