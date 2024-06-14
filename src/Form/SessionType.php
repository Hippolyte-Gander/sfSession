<?php

namespace App\Form;

use App\Entity\Session;
use App\Entity\Formateur;
use App\Entity\Stagiaire;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Validator\Constraints\GreaterThanOrEqual;

class SessionType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('titre', TextType::class, [
                'attr' => [
                    'class' => 'form-control'
                ]])
            ->add('nbrPlaces', IntegerType::class, [
                'constraints' => [
                    new GreaterThanOrEqual([
                        'value' => 0,
                        'message' => 'La valeur doit être positive.'
                    ])],
                'attr' => [
                    'class' => 'form-control',
                    'min' => '0'
                ]])
            ->add('dateDebut', DateType::class, [
                'widget' => 'single_text',
                'attr' => [
                    'class' => 'form-control'
                ]])
            ->add('dateFin', DateType::class, [
                'widget' => 'single_text',
                'attr' => [
                    'class' => 'form-control'
                ]])
            ->add('stagiaires', EntityType::class, [
                'class' => Stagiaire::class,
                'choice_label' => 'email',
                'multiple' => true,
                'required' => false,
                'attr' => [
                    'class' => 'form-control'
                ]])
            ->add('formateur', EntityType::class, [
                'class' => Formateur::class,
                'choice_label' => 'titre',
                // 'multiple' => true,
                'required' => false,
                'attr' => [
                    'class' => 'form-control'
            ]])
            ->add('Valider', SubmitType::class, [
                'attr' => [
                    'class' => 'btn btn-success'
                ]])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Session::class,
        ]);
    }
}
