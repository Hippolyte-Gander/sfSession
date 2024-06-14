<?php

namespace App\Controller;

use App\Entity\Session;
use App\Form\SessionType;
use App\Repository\SessionRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

class SessionController extends AbstractController
{

    #[Route('/session', name: 'app_session')]
    public function index(SessionRepository $sessionRepository): Response
    {
        $sessions = $sessionRepository->findAll();
        return $this->render('session/index.html.twig', [
            'sessions' => $sessions
        ]);
    }

    #[Route('/session/new', name: 'new_session')]
    #[Route('/session/{id}/edit', name: 'edit_session')]
    public function new(Session $session = null, Request $request, EntityManagerInterface $entityManager): Response
    { 
        if (!$session){
            $session = new Session();
        }

        $form =$this->createForm(SessionType::class, $session);

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            $session = $form->getData();
            // prepare en PDO
            $entityManager->persist($session);
            // execute en PDO
            $entityManager->flush();

            return $this->redirectToRoute('app_session');
        }

        return $this->render('session/new.html.twig', [
            'formAddSession' => $form,
            'edit' => $session->getId()
        ]);
    }

    #[Route('/session/{id}', name: 'show_session')]
    public function show(Session $session): Response
    {
        return $this->render('session/show.html.twig',[
            'session' => $session
        ]);
    }
}
