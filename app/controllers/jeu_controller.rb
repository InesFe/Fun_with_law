class JeuController < ApplicationController
  def index
    @decisions = Decision.all.shuffle
    @questions = []
    question_type = rand(1..3)
      case question_type
      when 1
        decision = @decisions.pop
        options = Decision.where.not(id: decision.id).sample(2)
        options << decision
        options.shuffle!
        correct_answer_id = decision.id
        @questions << {
            type: question_type,
            question: "Quel est le nom de l'arrêt rendu en #{decision.date} dont l'apport est le suivant: #{decision.summary}?",
            options: options.map { |option| [ option.name, option.id ] },
            correct_answer: correct_answer_id.to_i
        }
      when 2
        decision = @decisions.pop
        options = Decision.where.not(id: decision.id).sample(2)
        options << decision
        options.shuffle!
        correct_answer_id = decision.id
        @questions << {
            type: question_type,
            question: "En quelle année a été rendu l'arrêt #{decision.name} dont l'apport est le suivant: #{decision.summary}?",
            options: options.map { |option| [ option.date, option.id ] },
            correct_answer: correct_answer_id
        }
      when 3
        decision = @decisions.pop
        options = Decision.where.not(id: decision.id).sample(2)
        options << decision
        options.shuffle!
        correct_answer_id = decision.id
        @questions << {
            type: question_type,
            question: "Quel est l'apport de l'arrêt #{decision.name} rendu en  #{decision.date}?",
            options: options.map { |option| [ option.summary, option.id ] },
            correct_answer: correct_answer_id
        }
      end

      session[:correct_answer_ids] = []
      session[:correct_answer_ids] << correct_answer_id.to_s
      @current_question = @questions.first
      session[:questions] = @questions
      session[:current_question_index] = 0
  end

  def submit
  end
end
