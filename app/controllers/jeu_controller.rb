class JeuController < ApplicationController
  def index
    # if params[:chapter].present?
    # session[:selected_chapter] = params[:chapter]
    # session[:score] = 0
    # session[:compteur_questions] = 0
    # end

    if params[:chapter].present?
      session[:selected_chapter] = params[:chapter]
    end

    if session[:selected_chapter].present?
      @decisions = Decision.where(chapter: session[:selected_chapter]).shuffle
    else
      @decisions = Decision.all.shuffle
    end

    Rails.logger.info("Filtered Decisions: #{@decisions.inspect}")
    @questions = []
    question_type = rand(1..3)
      case question_type
      when 1
        decision = @decisions.pop
        options = @decisions.sample(2)
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
        options = @decisions.sample(2)
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
        options = @decisions.sample(2)
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
    # Retrieve questions and current_question_index from session
    @questions = session[:questions]
    @current_question_index = session[:current_question_index] || 0
    @current_question = @questions[@current_question_index]
    session[:score] ||= 0
    session[:compteur_questions] ||= 0

    correct_answer_id = session[:correct_answer_ids][@current_question_index].to_i
    # Check if the user has submitted an answer
    if params[:question].present? && params[:question][:answer_id].present?
      # Convert the submitted answer ID to an integer for comparison
      submitted_answer_id = params[:question][:answer_id].to_i
      session[:compteur_questions] += 1
      # Check if the submitted answer ID matches the correct answer ID
      if submitted_answer_id == correct_answer_id
        session[:score] += 1
        Rails.logger.info("Le score: #{session[:score]}")
        redirect_to jeu_correct_answer_path
      else
        correct_decision = Decision.find(correct_answer_id)
        redirect_to jeu_wrong_answer_path(correct_decision: correct_decision)
      end
      # Move to the next question
      session[:current_question_index] += 1

    else
      # Handle case when no answer is submitted
      flash[:error] = "Merci de choisir une réponse"
      redirect_to jeu_index_path
    end
    Rails.logger.info("Correct answer ID: ")
    Rails.logger.info("Submitted answer ID: #{submitted_answer_id}")
  end

  def correct_answer
  end

  def wrong_answer
    @correct_decision = Decision.find(params[:correct_decision]) if params[:correct_decision]
  end
end
