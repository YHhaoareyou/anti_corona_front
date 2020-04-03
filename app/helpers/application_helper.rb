module ApplicationHelper
  def suppliments_names_units
    {
      'mask' => {'name' => t('suppliments.mask'), 'unit' => t('suppliments_unit.mask')},
      'medical_mask' => {'name' => t('suppliments.medical_mask'), 'unit' => t('suppliments_unit.medical_mask')},
      'hand_sanitizer' => {'name' => t('suppliments.hand_sanitizer'), 'unit' => t('suppliments_unit.hand_sanitizer')},
      'bleach_solution' => {'name' => t('suppliments.bleach_solution'), 'unit' => t('suppliments_unit.bleach_solution')},
      'alcohol_wet_wipe' => {'name' => t('suppliments.alcohol_wet_wipe'), 'unit' => t('suppliments_unit.alcohol_wet_wipe')},
      'tissue_paper' => {'name' => t('suppliments.tissue_paper'), 'unit' => t('suppliments_unit.tissue_paper')},
      'toilet_paper' => {'name' => t('suppliments.toilet_paper'), 'unit' => t('suppliments_unit.toilet_paper')},
      'other' => {'name' => t('suppliments.other')}
    }
  end

  def translation_table
  end
end
