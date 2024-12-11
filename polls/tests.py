import datetime

from django.test import TestCase

from .models import Question
from django.utils import timezone


# Create your tests here.

class QuestionModelTests(TestCase):
    def test_length(self):
        self.assertIs(len("hello"), 6)

    def test_was_published_recently_with_future_question(self):
        time = timezone.now() + datetime.timedelta(days=30)
        future_question = Question(pub_date=time)

        self.assertIs(future_question.was_published_recently(), False)