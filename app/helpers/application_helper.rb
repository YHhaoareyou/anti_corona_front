module ApplicationHelper
  def suppliments_names_units
    {
      'cloth_mask' => {'name' => t('suppliments.cloth_mask'), 'unit' => t('suppliments_unit.cloth_mask')},
      'medical_mask' => {'name' => t('suppliments.medical_mask'), 'unit' => t('suppliments_unit.medical_mask')},
      'n95_mask' => {'name' => t('suppliments.n95_mask'), 'unit' => t('suppliments_unit.n95_mask')},
      'hand_sanitizer' => {'name' => t('suppliments.hand_sanitizer'), 'unit' => t('suppliments_unit.hand_sanitizer')},
      'bleach_solution' => {'name' => t('suppliments.bleach_solution'), 'unit' => t('suppliments_unit.bleach_solution')},
      'alcohol_wet_wipe' => {'name' => t('suppliments.alcohol_wet_wipe'), 'unit' => t('suppliments_unit.alcohol_wet_wipe')},
      'tissue_paper' => {'name' => t('suppliments.tissue_paper'), 'unit' => t('suppliments_unit.tissue_paper')},
      'toilet_paper' => {'name' => t('suppliments.toilet_paper'), 'unit' => t('suppliments_unit.toilet_paper')},
      'other' => {'name' => t('suppliments.other')}
    }
  end

  def default_meta_tags
    {
      site: t('menu.brand'),
      title: t('home.title'),
      reverse: true,
      charset: 'utf-8',
      description: "#{t('home.subtitle')} #{t('home.subtitle2')}",
      keywords: "#{t('about1')} #{t('about2')} #{t('about3')}",
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
      }
    }
  end
end
