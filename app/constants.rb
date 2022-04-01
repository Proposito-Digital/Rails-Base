# frozen_string_literal: true
module Constants
	DAYS = {  	
    monday: 'Segunda-feira',
    tuesday: 'Terça-feira',
    wednesday: 'Quarta-feira',
    thursday: 'Quinta-feira',
    friday: 'Sexta-feira',
    saturday:'Sabado',
    sunday: 'Domingo'
  }

  DURATION = {  	
    I18n.t('numbers.one') => 1,
    I18n.t('numbers.two') => 2,
    I18n.t('numbers.three') => 3,
    I18n.t('numbers.four') => 4,
    I18n.t('numbers.five') => 5,
    I18n.t('numbers.eight') => 8,
    I18n.t('numbers.thirteen') => 13,
    I18n.t('numbers.twentyone') => 21,
  }

  PAYMENT_TYPES = {
    credit_card: 0,
    billet: 1, #boleto
    internal: 2, #administrativo
  }

end