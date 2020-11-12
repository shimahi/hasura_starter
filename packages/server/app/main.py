from fastapi import FastAPI
from ariadne.asgi import GraphQL
from ariadne import QueryType, load_schema_from_path, make_executable_schema

type_defs = load_schema_from_path("graphql/typeDefs.graphql")
query = QueryType()


@query.field("hello")
def resolve_hello(*_, name: str):
    return f"Hello, {name}!!"


@query.field("goodbye")
def resolve_goodbye(*_):
    return "goodbye!"


@query.field("members")
def resolve_members(*_):
    return [{"name": "shimahi", "part": "guitar"}, {"name": "mochi", "part": "vocal"}]


schema = make_executable_schema(type_defs, query)

app = FastAPI()
app.add_route("/", GraphQL(schema, debug=True))


@app.get("/inu")
async def inu_page():
    return {"message": "いぬ〜"}
