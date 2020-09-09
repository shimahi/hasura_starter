from ariadne import QueryType, gql, make_executable_schema
from ariadne.asgi import GraphQL
from fastapi import FastAPI


type_defs = gql("""
    type Query {
        hello(name: String = "いぬ"): String!
        goodbye: String!
        members: [Member!]!
    }

    type Member {
        name: String!
        part: String!
    }
""")

query = QueryType()


@query.field("hello")
def resolve_hello(*_, name):
    return f"Hello, {name}!!"


@query.field("goodbye")
def resolve_goodbye(*_):
    return "goodbye!"


@query.field("members")
def resolve_members(*_):
    return [
        {
            "name": "shimahi",
            "part": "guitar"
        },
        {
            "name": "mochi",
            "part": "vocal"
        }
    ]


schema = make_executable_schema(type_defs, query)

app = FastAPI()
app.add_route("/", GraphQL(schema, debug=True))
