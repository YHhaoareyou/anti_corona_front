module ApplicationHelper
  def suppliments_names_units
    {
      'mask' => {'eng_name' => 'Mask', 'eng_unit' => 'pieces'},
      'medical_mask' => {'eng_name' => 'Medical mask', 'eng_unit' => 'pieces'},
      'hand_sanitizer_spray' => {'eng_name' => 'Hand sanitizer spray', 'eng_unit' => 'ml'},
      'hand_sanitizer_gel' => {'eng_name' => 'Hand sanitizer gel', 'eng_unit' => 'ml'},
      'alcohol_wet_wipe' => {'eng_name' => 'Alcohol wet wipe', 'eng_unit' => 'pieces'},
      'tissue_paper' => {'eng_name' => 'Tissue paper', 'eng_unit' => 'boxes'},
      'toilet_paper' => {'eng_name' => 'Toilet paper', 'eng_unit' => 'rolls'},
      'other' => {'eng_name' => 'Other', 'eng_unit' => ''}
    }
  end

  def translation_table
  end
end
