from django.db import models
from django.core.serializers.json import DjangoJSONEncoder
from django.forms.models import model_to_dict
import json

class Question(models.Model):
    question_text = models.CharField(max_length=200)
    pub_date = models.DateTimeField("date published")
    def __str__(self):
        return json.dumps(model_to_dict(self), cls=DjangoJSONEncoder, ensure_ascii=False)

class Choice(models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    choice_text = models.CharField(max_length=200)
    votes = models.IntegerField(default=0)
    def __str__(self):
        return json.dumps(model_to_dict(self), cls=DjangoJSONEncoder, ensure_ascii=False)