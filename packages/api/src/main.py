from graphene import Schema, ObjectType, Field, String, List
from fastapi import FastAPI
from starlette.graphql import GraphQLApp


class Member(ObjectType):
    name = String()
    part = String()


class Query(ObjectType):
    hello = String(name=String(default_value="いぬ"))
    goodbye = String()
    member = Field(List(Member))

    def resolve_hello(self, info, name):
        return "Hello " + name + "!"

    def resolve_goodbye(self, info):
        return "Goodbye!"

    def resolve_member(_, info):
        return [
            {
                "name": "shimahi",
                "part": "guitar",
            },
            {
                "name": "mochi",
                "part": "vocal"
            }
        ]


app = FastAPI()
app.add_route("/", GraphQLApp(schema=Schema(query=Query)))
